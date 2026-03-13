import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn } from "typeorm"

@Entity("gateways")
export class Gateway {
    @PrimaryGeneratedColumn()
    id: number

    @Column({ length: 100 })
    name: string

    @Column()
    priority: number

    @Column({ default: true })
    isActive: boolean

    @Column()
    apiUrl: string

    @CreateDateColumn({ name: 'created_at' })
    createdAt: Date
}