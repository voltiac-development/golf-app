import bcrypt from 'bcrypt';
import { v4 as uuid } from 'uuid';
import { Account, genderType } from '../interfaces/Authentication';
import jwt from 'jsonwebtoken';

export async function createProfile(email: string, name: string, password: string, favcourse: string, gender: string): Promise<Account> {
    return {
        id: uuid(),
        email: email,
        name: name,
        password: await encrypt(password),
        created_on: Date.now(),
        last_access: Date.now(),
        verified: false,
        gender: gender as genderType,
        role: "USER",
        favcourse: favcourse,
        handicap: 54.0
    }
}

export async function encrypt(password: string): Promise<string> {
    return await bcrypt.hash(password, 10);
}

export async function verifyPassword(password: string, hash: string) {
    return await bcrypt.compare(password, hash);
}

export function clean(account: Account) {
    return {
        id: account.id,
        name: account.name,
        email: account.email,
        role: account.role,
        verified: account.verified,
        handicap: account.handicap,
        course: account.favcourse,
        gender: account.gender
    }
}