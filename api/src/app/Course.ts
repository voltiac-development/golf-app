import { fetchAllCourses } from "../data/Course.js";
import { HTTPError } from "../errors/HTTPError.js";

export async function getAllCourses(): Promise<{data: Object, error: HTTPError}> {
    const { data, error } = await fetchAllCourses();

    let response = {
        data: null,
        error: null
    }

    if (error) {
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else
        response.data = {'courses': data};

    return response;
}