import bcrypt from 'bcrypt';
import { v4 as uuid } from 'uuid';
import { Account } from '../interfaces/Authentication';
import jwt from 'jsonwebtoken';

export async function createProfile(email: string, name: string, password: string): Promise<Account> {
    return {
        id: uuid(),
        email: email,
        name: name,
        password: await encrypt(password),
        created_on: Date.now(),
        last_access: Date.now(),
        verified: false,
        phone_number: "",
        role: "USER",
    }
}

async function encrypt(password: string): Promise<string> {
    return await bcrypt.hash(password, 10);
}

export async function verifyPassword(password: string, hash: string) {
    return await bcrypt.compare(password, hash);
}

export function clean(account: Account) {
    return {
        name: account.name,
        email: account.email,
        role: account.role,
        verified: account.verified
    }
}