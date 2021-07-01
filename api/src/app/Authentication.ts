import { addUserToDatabase, fetchUserData } from "../data/Authentication.js";
import { LoginResponse, RegisterResponse } from "../interfaces/Authentication.js";
import { HTTPError } from '../errors/HTTPError.js'
import { createProfile, verifyPassword, clean } from "./Account.js";
import { generateJWT } from "./Session.js";

export async function login(email: string, password: string): Promise<LoginResponse> {
    const { data, error } = await fetchUserData(email);

    let response: LoginResponse = {
        data: null,
        error: null
    }
 
    if (error) {
        response.error = new HTTPError(404, "User not found with the provided email.");
    }

    if (data && await verifyPassword(password, data.password)) {
        let jwt = await generateJWT(data);
        response.data = {
            jwtToken: jwt,
            userData: clean(data)
        }
    } else if (data) {
        response.error = new HTTPError(401, "Username and/or Password are incorrect.")
    }

    return response;
}

export async function register(email: string, username: string, password: string, password_verify: string, favcourse: string): Promise<RegisterResponse> {
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
        response.error = new HTTPError(409, "A user exists with your email.");
    } else {
        const account = await createProfile(email, username, password, favcourse);

        if ((await addUserToDatabase(account)).data) {
            let jwt = await generateJWT(account);
            response.data = {
                jwtToken: jwt,
                userData: clean(account)
            }
        } else {
            response.error = new HTTPError(500, "The server wasn't able to store your data.");
        }
    }

    return response;
}