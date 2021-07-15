import { fetchAllCourses, fetchRoundTypes, fetchSpecificCourse } from "../data/Course.js";
import { HTTPError } from "../errors/HTTPError.js";

export async function getAllCourses(): Promise<{data: Object, error: HTTPError}> {
    let { data, error } = await fetchAllCourses();
    for(let i = 0; i < data.length; i++){
        data[i]['roundTypes'] = (await fetchRoundTypes(data[i]['id'])).data
    }

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

export async function getSpecficCourse(courseId: string): Promise<{data: Object, error: HTTPError}> {
    var { data, error } = await fetchSpecificCourse(courseId);
    let roundData = await fetchRoundTypes(courseId);
    data.roundTypes = roundData.data;

    let response = {
        data: null,
        error: null
    }

    if (error || roundData.error) {
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else
        response.data = data;

    return response;
}