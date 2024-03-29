.import QtQuick.LocalStorage 2.12 as LS

function init() {
    const db = getHandle();
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS brand (id INTEGER PRIMARY KEY, name varchar(50) unique)');
            tx.executeSql('CREATE TABLE IF NOT EXISTS brand_in_stock (brand_id int not null unique, FOREIGN KEY (brand_id) REFERENCES brand(id))');
            tx.executeSql('CREATE TABLE IF NOT EXISTS floss (id INTEGER PRIMARY KEY, brand_id int not null, number varchar(15), description varchar(200), rgb_color varchar(10), FOREIGN KEY (brand_id) REFERENCES brand(id), UNIQUE(brand_id, number) on conflict ignore)');
            tx.executeSql('CREATE TABLE IF NOT EXISTS floss_in_stock (floss_id int not null unique, quantity int DEFAULT 0 check(quantity >= 0), FOREIGN KEY (floss_id) REFERENCES floss(id))');
            tx.executeSql('CREATE TABLE IF NOT EXISTS project (id INTEGER PRIMARY KEY, name text)');
            tx.executeSql('CREATE TABLE IF NOT EXISTS project_floss (project_id int, floss_id, FOREIGN KEY (project_id) REFERENCES project(id), FOREIGN KEY (floss_id) REFERENCES floss(id))');
        })
    } catch (err) {
        console.log("Error creating tables in database: " + err);
    };
}
function getHandle() {
    let db;
    try {
        db = LS.LocalStorage.openDatabaseSync("Needlewoman_DB", "0.9",
                                               "Needlewoman notebook", 1000000);
    } catch (err) {
        console.log("Error opening database: " + err);
    }
    return db;
}

function insertFlossFromJson(array) {
    const db = getHandle();
    var currentBrand = ""
    var brand_id = 0;
    try {
        db.transaction(function(tx) {
            array.forEach (item => {
               if (item.brand !== currentBrand) {
                   tx.executeSql('INSERT OR IGNORE INTO brand (name) VALUES (?)', [item.brand]);
                   brand_id = tx.executeSql('select id from brand where name = ?',[item.brand]).rows.item(0).id;
               }
               tx.executeSql('INSERT OR IGNORE INTO floss (brand_id, number, description, rgb_color) VALUES (?, ?, ?, ?)', [brand_id, item.number, item.name, item.color]);
           })
        })
    } catch (err) {
        console.log("Error insert in table floss: " + err);
    };
}

function fillDatabase(){
    var xhr = new XMLHttpRequest;
    xhr.open("GET", "../data/floss.json"); // set Method and File
    xhr.onreadystatechange = function () {
        if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
            var response = xhr.responseText;

            var data = JSON.parse(xhr.responseText);
            insertFlossFromJson(data);
        }
    }
    xhr.send(); // begin the request
}

function getFlossWithBrand(brand_id) {
    const db = getHandle();
    let array = [];
    db.transaction(function (tx) {
        const result = tx.executeSql('SELECT id, rgb_color, description, number FROM floss WHERE brand_id = ?', [brand_id]);
        for (let i = 0; i < result.rows.length; i++) {
            array.push({
                           number: result.rows.item(i).number,
                           available: true,
                           quantity: 0,
                           name: result.rows.item(i).description,
                           flossColor: result.rows.item(i).rgb_color,
                           id: result.rows.item(i).id
                         });
        }
    });
    return array;
}

function getSuitableFloss(brand_id, available, text) {
    const db = getHandle();
    var capital = text.charAt(0).toUpperCase() + text.slice(1);
    var lower = text.toLowerCase();
    let array = [];
    db.transaction(function (tx) {
        const result = tx.executeSql('SELECT floss.id as id, rgb_color, description, number, COALESCE(quantity, 0) AS q FROM floss LEFT JOIN floss_in_stock ON floss.id = floss_in_stock.floss_id WHERE brand_id = ? AND (number LIKE ? OR description LIKE ? OR description LIKE ?) AND (' + available + ' = 0 OR (' + available + ' = 1 AND q > 0) OR (' + available + ' = 2 AND q = 0))', [brand_id, "%" + text + "%", capital + "%",  "%" + lower + "%"]);
        for (let i = 0; i < result.rows.length; i++) {
            array.push({
                           number: result.rows.item(i).number,
                           available: result.rows.item(i).q > 0,
                           quantity: result.rows.item(i).q,
                           name: result.rows.item(i).description,
                           flossColor: result.rows.item(i).rgb_color,
                           floss_id: result.rows.item(i).id
                         });
        }
    });
    return array;
}

function getBrandsInStock() {
    const db = getHandle();
    let array = [];
    db.transaction(function (tx) {
        const result = tx.executeSql('SELECT id, name FROM brand_in_stock LEFT JOIN brand ON brand.id = brand_in_stock.brand_id');
        for (let i = 0; i < result.rows.length; i++) {
            array.push({
                         id: parseInt(result.rows.item(i).id),
                         name: result.rows.item(i).name});
        }
    });
    return array;
}

function insertFlossInStock(floss_id, quantity) {
    const db = getHandle();
    db.transaction(function (tx) {
       if (quantity === 0) {
           tx.executeSql('DELETE FROM floss_in_stock WHERE floss_id = ?', [floss_id])
       } else {
          tx.executeSql('INSERT OR REPLACE INTO floss_in_stock(floss_id, quantity) VALUES(?, ?)', [floss_id, quantity])
       }
    });
}

function getUnusedBrands() {
    const db = getHandle();
    let array = [];
    db.transaction(function (tx) {
        const result = tx.executeSql('SELECT ids.id, name FROM (SELECT id FROM brand EXCEPT SELECT brand_id FROM brand_in_stock) as ids LEFT JOIN brand ON ids.id = brand.id');
        for (let i = 0; i < result.rows.length; i++) {
            array.push({
                         id: parseInt(result.rows.item(i).id),
                         name: result.rows.item(i).name});
        }
    });
    return array;
}

function insertBrandInStock(brand_id) {
    const db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('INSERT OR IGNORE INTO brand_in_stock(brand_id) VALUES(?)', [brand_id]);
    });
}

function hideBrand(id) {
    const db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM brand_in_stock WHERE brand_id = ?', [id]);
    });
}

function deleteBrand(id) {
    const db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM brand_in_stock WHERE brand_id = ?', [id]);
        tx.executeSql('DELETE FROM floss_in_stock WHERE floss_id IN (SELECT floss_id FROM floss_in_stock LEFT JOIN floss ON floss.id = floss_in_stock.floss_id WHERE floss.brand_id = ?)', [id]);
    });
}

function getBrands() {
    const db = getHandle();
    let array = [];
    db.transaction(function (tx) {
        const result = tx.executeSql('SELECT id, name FROM brand');
        for (let i = 0; i < result.rows.length; i++) {
            array.push({
                         id: parseInt(result.rows.item(i).id),
                         name: result.rows.item(i).name});
        }
    });
    return array;
}

function getFloss(brand_id) {
    const db = getHandle();
    let array = [];
    db.transaction(function (tx) {
        const result = tx.executeSql('SELECT id, number FROM floss WHERE brand_id = ?', [brand_id]);
        for (let i = 0; i < result.rows.length; i++) {
            array.push({
                   number: result.rows.item(i).number,
                   id: result.rows.item(i).id
                 });
        }
    });
    return array;
}

function getColors() {
    const db = getHandle();
        let array = [];
        db.transaction(function (tx) {
            const result = tx.executeSql('SELECT id, rgb_color FROM floss');
            for (let i = 0; i < result.rows.length; i++) {
                array.push({
                       id: result.rows.item(i).id,
                       rgb: result.rows.item(i).rgb_color
                     });
            }
        });
        return array;
}

function getSimilarFlossInfo(idArray) {
    const db = getHandle();
        let array = [];
        db.transaction(function (tx) {
            idArray.forEach(item => {
                                var result = tx.executeSql('SELECT rgb_color, description, number, COALESCE(quantity, 0) AS q, brand.name as brand_name FROM floss LEFT JOIN floss_in_stock ON floss.id = floss_in_stock.floss_id LEFT JOIN brand ON floss.brand_id = brand.id WHERE floss.id = ?', [item.id]);
                                array.push({ brand: result.rows.item(0).brand_name,
                                             flossColor: result.rows.item(0).rgb_color,
                                             name: result.rows.item(0).description,
                                             number: result.rows.item(0).number,
                                             quantity: result.rows.item(0).q
                                           });
                            });
        });
        return array;
}

