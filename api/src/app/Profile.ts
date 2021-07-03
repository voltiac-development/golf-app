import { fetchUserData, getUserFromId, updateUserData } from "../data/Authentication.js";
import { HTTPError } from "../errors/HTTPError.js";
import { Account } from "../interfaces/Authentication.js";
import { clean, encrypt } from "./Account.js";
import { validateJWT, GetIdFromSession } from "./Session.js";

export async function getCurrentUserDetails(cookie: string): Promise<{ data: object; error: HTTPError; }> {
    let r = {
        data: null,
        error: null,
    }

    if (!cookie) {
        r.error = new HTTPError(401, "'gc_auth' cookie mist.");
    } else {
        let { data, error } = validateJWT(cookie);

        if (error) {
            r.error = new HTTPError(403, "'gc_auth' cookie is niet valide.");
        }

        if (data) {
            r.data = clean((await fetchUserData(data.sub)).data);
        }
    }

    return r;
}

export async function editCurrentUserDetails(cookie: string, name: string, email: string, newPassword: string, newVerifiedPassword: string): Promise<{data: object, error: HTTPError}> {
    let r = {
        data: null,
        error: null,
    }
    
    if(newPassword != newVerifiedPassword){
        r.error = "Wachtwoorden komen niet overeen."
        return r;
    }

    if (!cookie) {
        r.error = new HTTPError(401, "'gc_auth' cookie mist.");
    } else {
        let { data, error } = validateJWT(cookie);

        if (error) {
            r.error = new HTTPError(403, "'gc_auth' cookie is niet valide.");
        }

        if (data) {
            let id = await GetIdFromSession(data.sub);
            let account = (await getUserFromId(id.data)).data;
            let newAccount: Account = {
                id: id.data,
                email: email,
                name: name,
                password: await encrypt(newPassword),
                created_on: account.created_on,
                verified: account.verified,
                last_access: Date.now(),
                phone_number: account.phone_number,
                role: account.role,
                favcourse: account.favcourse
            }

            r.data = await (await updateUserData(account)).data;
        }
    }

    return r;
}