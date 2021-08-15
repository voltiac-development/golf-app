import { getUserFromId, updateUserData } from "../data/Authentication.js";
import { HTTPError } from "../errors/HTTPError.js";
import { Account, genderType } from "../interfaces/Authentication.js";
import { clean, encrypt, verifyPassword } from "./Account.js";
import { validateJWT, GetIdFromSession } from "./Session.js";

export async function getCurrentUserDetails(cookie: string): Promise<{ data: object; error: HTTPError; }> {
    let r = {
        data: null,
        error: null,
    }

    if (!cookie) {
        r.error = new HTTPError(401, "'gc-auth' cookie mist.");
    } else {
        let { data, error } = validateJWT(cookie);

        if (error) {
            r.error = new HTTPError(403, "'gc-auth' cookie is niet valide.");
        }

        if (data) {
            let id = await GetIdFromSession(data.jti);
            if(id.data){
                let d = await getUserFromId(id.data);
                r.data = clean(d.data);
            }
        }
    }

    return r;
}

export async function editCurrentUserDetails(cookie: string, name: string, email: string, newPassword: string, newVerifiedPassword: string, currentPassword: string, handicap: number, gender: string): Promise<{data: object, error: HTTPError}> {
    let r = {
        data: null,
        error: null,
    }
    
    if(newPassword != newVerifiedPassword){
        r.error = new HTTPError(400, "Wachtwoorden komen niet overeen.")
        return r;
    }

    if (!cookie) {
        r.error = new HTTPError(401, "'gc-auth' cookie mist.");
    } else {
        let { data, error } = validateJWT(cookie);

        if (error) {
            r.error = new HTTPError(403, "'gc-auth' cookie is niet valide.");
            return r;
        }

        if (data) {
            let id = await GetIdFromSession(data.jti);
            let accountData = await getUserFromId(id.data);
            let account = accountData.data;

            if(currentPassword != "" && newPassword != "" && newVerifiedPassword != ""){
                if(!await verifyPassword(currentPassword, account.password)) {
                    r.error = new HTTPError(400, 'Huidig wachtwoord komt niet overeen.');
                    return r;
                }
            }

            console.log(gender)

            let newAccount: Account = {
                id: id.data,
                email: email,
                name: name,
                password: newPassword != "" ? await encrypt(newPassword) : account.password,
                created_on: account.created_on,
                verified: account.verified,
                last_access: Date.now(),
                gender: gender as genderType,
                role: account.role,
                favcourse: account.favcourse,
                handicap: handicap
            }
            await updateUserData(newAccount);
            r.data = "SUCCESS";
        }
    }

    return r;
}