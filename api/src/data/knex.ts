import pkg from 'knex'
const { Knex, knex } = pkg;

const config = {
    client: 'mysql',
    connection: {
        host : '185.182.56.248',
        user : process.env.dbuser,
        password : process.env.dbpassword,
        database : process.env.dbname
    },
  };
  
const knexInstance = knex(config);

export const sql = knexInstance;