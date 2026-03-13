import "reflect-metadata"
import { DataSource } from "typeorm"
import { env } from '../env.js' // Pegando as variáveis validadas do Adonis

export const AppDataSource = new DataSource({
    type: "mysql",
    host: process.env.DB_HOST || "localhost",
    port: Number(process.env.DB_PORT) || 3306,
    username: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "root",
    database: process.env.DB_DATABASE || "betalent_api",
    synchronize: false, // Database-First: Não deixamos o ORM mudar o schema
    logging: process.env.NODE_ENV === "development",
    entities: ["app/entities/*.ts"], // Onde nossas entidades viverão
    migrations: ["database/migrations/*.ts"],
    subscribers: [],
})