import jwt from "jsonwebtoken";
import { v4 as uuid } from 'uuid';
import { Account } from "../interfaces/Authentication.js";
import { JWTToken } from "../interfaces/Session.js";
import { addSessionToDatabase, fetchSessionData } from '../data/Authentication.js'

export async function generateJWT(account: Account): Promise<string> {
    let sessionId = uuid()
    await addSessionToDatabase(sessionId, account.id, Date.now())
    return jwt.sign({
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
        console.log(e)
        r.error = e;
    }

    return r;
}

export async function GetIdFromSession(session: string): Promise<{ data: string, error: Error }> {
    let r = {
        data: null,
        error: null,
    }

    try {
        var sessionData = await fetchSessionData(session);
        r.data = sessionData.data.uid;
    } catch (e) {
        r.error = sessionData.error;
    }

    return r;
}