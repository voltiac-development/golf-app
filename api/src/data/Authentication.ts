import { Account } from "../interfaces/Authentication.js";
import { Session } from "../interfaces/Session.js"
import { sql } from "./knex.js";


export async function fetchUserData(email: string): Promise<{ data: Account, error: Error }> {
    let userData = null, error = null;

    try {
        userData = await sql<Account>('accounts').select('*').where({email: email})
        if(userData.length > 0)
            userData = userData[0]
        else{
            userData = null;
            error = "Not found";
        }
    } catch (e) {
        error = e;
    }

    return {
        data: userData,
        error
    }
}

export async function addUserToDatabase(account: Account): Promise<{ data: Account, error: Error }> {
    let r = {
        data: null,
        error: null,
    }

    try {
        r.data = await sql<Account>('accounts').insert(account)
    } catch (e) {
        r.error = e;
    }

    return {
        data: r.data,
        error: r.error
    };
}

export async function fetchSessionData(sessionID: string): Promise<{ data: String, error: Error }> {
    let r = {
        data: null,
        error: null,
    }

    try {
        let result = await sql<Session>('sessions').select('*').where({sessionId: sessionID})
        if(result.length > 0)
            r.data = result[0]
        else
            r.error = "NOT_FOUND";
    } catch (e) {
        r.error = e;
    }

    return {
        data: r.data,
        error: r.error
    };
}

export async function addSessionToDatabase(sessionId: string, userId: string, createdAt: number): Promise<{data: string, error: Error}> {
    let r = {
        data: sessionId,
        error: null,
    }

    try {
        await sql<Session>('sessions').insert({sessionId: sessionId, uid: userId, createdAt: createdAt})
    } catch (e) {
        r.error = e;
    }

    return {
        data: r.data,
        error: r.error
    };
}