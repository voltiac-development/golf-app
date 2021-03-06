import { addUserToDatabase, fetchUserData, addForgotRequestKey } from "../data/Authentication.js";
import { LoginResponse, RegisterResponse } from "../interfaces/Authentication.js";
import { HTTPError } from '../errors/HTTPError.js'
import { createProfile, verifyPassword, clean } from "./Account.js";
import { generateJWT } from "./Session.js";
import { sendNewUserMail, sendForgotMail } from "./Notification.js";
import * as uuid from 'uuid'

export async function login(email: string, password: string): Promise<LoginResponse> {
    const { data, error } = await fetchUserData(email);

    let response: LoginResponse = {
        data: null,
        error: null
    }
 
    if (error) {
        response.error = new HTTPError(404, "Geen gebruiker gevonden met deze e-mail.");
    }

    if (data && await verifyPassword(password, data.password)) {
        let jwt = await generateJWT(data);
        response.data = {
            jwtToken: jwt,
            userData: clean(data)
        }
    } else if (data) {
        response.error = new HTTPError(401, "Gebruikersnaam en/of wachtwoord kloppen niet.")
    }

    // await sendNewUserMail(data.name, "https://voltiac.dev", data.email);
    return response;
}

export async function register(email: string, username: string, password: string, password_verify: string, favcourse: string, gender: string): Promise<RegisterResponse> {
    if(password !== password_verify){
        return {
            data: null,
            error: new HTTPError(401, "Wachtwoorden komen niet overeen"),
        } 
    }
    const { data, error } = await fetchUserData(email);

    let response: RegisterResponse = {
        data: null,
        error: null,
    }

    if (data) {
        response.error = new HTTPError(409, "Een gebuiker bestaat al met dit e-mail.");
    } else {
        const account = await createProfile(email, username, password, favcourse, gender);
        let addObj = await addUserToDatabase(account);
        if (addObj.data) {
            let jwt = await generateJWT(account);
            response.data = {
                jwtToken: jwt,
                userData: clean(account)
            }
        } else {
            console.log(addObj.error)
            response.error = new HTTPError(500, "Probleem met de server. Probeer later opnieuw.");
        }
    }

    return response;
}

export async function requestForgot(email: string): Promise<RegisterResponse> {
    const { data, error } = await fetchUserData(email);

    let response: RegisterResponse = {
        data: null,
        error: null,
    }

    if (!data) {
        response.error = new HTTPError(409, "Gebruiker niet gevonden.");
    } else {
        let r = await addForgotRequestKey(data.id, uuid.v4() + "_" + uuid.v4() + "_" + uuid.v4())
        let key = r.data;
        await sendForgotMail(data.name, data.email, process.env.LINK + "/auth/forgot/" + key)
        response.data = {result: "SUCCESS"}
    }

    return response;
}

export async function processForgot(keyId: string, uid: string, newpassword: string): Promise<RegisterResponse> {

    let response: RegisterResponse = {
        data: null,
        error: null,
    }

    return response;
}

export async function isAuthenticated(req, res, next) {
    if(req['user']) next();
    else res.status(401).send({error: "NOT_AUTHENTICATED"})
}

export async function isNotAuthenticated(req, res, next) {
    if(!req['user']) next();
    else res.status(401).send({error: "NOT_AUTHENTICATED"})
}