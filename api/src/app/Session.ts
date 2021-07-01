import jwt from "jsonwebtoken";
import { v4 as uuid } from 'uuid';
import { Account } from "../interfaces/Authentication.js";
import { JWTToken } from "../interfaces/Session.js";
import { addSessionToDatabase } from '../data/Authentication.js'

export async function generateJWT(account: Account): Promise<string> {
    let sessionId = uuid()
    await addSessionToDatabase(sessionId, account.id, Date.now())
    return jwt.sign({
        exp: Math.floor(Date.now() / 1000) + (60 * 60 * 24 * 30),
        iat: Date.now(),
        jti: sessionId,
        iss: "Voltiac",
        sub: account.email,
        auth_level: account.role,
    }, process.env.JWT_KEY);
}

export function validateJWT(jwtToken: string): { data: JWTToken, error: Error } {
    let r = {
        data: null,
        error: null,
    }

    try {
        r.data = jwt.verify(jwtToken, process.env.JWT_KEY);
    } catch (e) {
        r.error = e;
    }

    return r;
}