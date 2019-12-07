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

/*function insertBrand(db, brand_name) {
    let id = 0
    try {
        db.transaction(function (tx) {
            tx.executeSql('INSERT OR IGNORE INTO brand (name) VALUES (?)', [brand_name]);
            id = tx.executeSql('select id from brand where name = ?',[brand_name]).rows.item(0).id;
        })
    } catch (err) {
        console.log("Error insert in table brand: " + err);
    };
    return parseInt(id);
}

function insertFloss(db, number, description, brand, rgb_color) {
    try {
        db.transaction(function (tx) {
            var brand_id = insertBrand(db, brand)
            tx.executeSql('INSERT OR IGNORE INTO floss (brand_id, number, description, rgb_color) VALUES (?, ?, ?, ?)', [brand_id, number, description, rgb_color]);
        })
    } catch (err) {
        console.log("Error insert in table floss: " + err);
    };
}*/

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

/*function readAll(dictId) {
    const db = getHandle();
    let array = [];
    db.transaction(function (tx) {
        const result = tx.executeSql('SELECT id, rgb_color, description, brand_id, number FROM floss');
        for (let i = 0; i < result.rows.length; i++) {
            array.push({
                           number: result.rows.item(i).number,
                           available: true,
                           quantity: result.rows.item(i).brand_id,
                           name: result.rows.item(i).description,
                           flossColor: result.rows.item(i).rgb_color,
                           id: result.rows.item(i).id
                         });
        }
    });
    return array;
}*/

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
    let array = [];
    db.transaction(function (tx) {
        const result = tx.executeSql('SELECT id, rgb_color, description, number FROM floss WHERE brand_id = ?', [brand_id]);// , AND (number LIKE \'%?%\' OR description LIKE \'%?%\')
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

function getBrandsInStock() {
    const db = getHandle();
    let array = [];
    db.transaction(function (tx) {
        const result = tx.executeSql('SELECT id, name FROM brand ORDER BY id');
        for (let i = 0; i < result.rows.length; i++) {
            array.push({
                         id: parseInt(result.rows.item(i).id),
                          name: result.rows.item(i).name});
        }
    });
    return array;
}

