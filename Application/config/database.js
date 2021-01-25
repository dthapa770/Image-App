const mysql=require('mysql2');

const pool=mysql.createPool({

    host:'localhost',
    user: 'dinesh',
    password:'password123',
    database: 'csc317db',
    connectionLimit:50,
    debug:false,

});

const promisePool=pool.promise(); // For Promise Use
   module.exports=promisePool;
// module.exports=pool;