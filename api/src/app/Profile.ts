import { fetchUserData } from "../data/Authentication.js";
import { HTTPError } from "../errors/HTTPError.js";
import { clean } from "./Account.js";
import { validateJWT } from "./Session.js";

export async function getCurrentUserDetails(cookie: string): Promise<{ data: object; error: HTTPError; }> {
    let r = {
        data: null,
        error: null,
    }

    if (!cookie) {
        r.error = new HTTPError(401, "'VOLTIAC.AUTH' cookie is not set.");
    } else {
        let { data, error } = validateJWT(cookie);

        if (error) {
            r.error = new HTTPError(403, "'VOLTIAC.AUTH' cookie is invalid.");
        }

        if (data) {
            r.data = clean((await fetchUserData(data.sub)).data);
        }
    }

    return r;
}