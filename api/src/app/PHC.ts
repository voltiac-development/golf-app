import { fetchPlayingHandicap } from "../data/PHC.js";
import { HTTPError } from "../errors/HTTPError.js";
import { getSpecificProfile } from "./Profile.js";

export async function getAllPlayingHandicaps(holeTypeId: string, players: string[], teeboxes: number[]): Promise<{data: number[], error: HTTPError}> {
    var data = [0, 0, 0, 0],
    error = null
    for(let i = 0; i < players.length; i++){
        if(players[i] == null) continue;
        let playerData = await getSpecificProfile(players[i]);
        if(playerData.error) error = new HTTPError(404, "Er is een probleem met uw aanvraag.");
        let player = playerData.data;
        let d = await fetchPlayingHandicap(holeTypeId, teeboxes[i], player.handicap, player.gender == "MALE" ? 1 : 0);
        if(d.error) error = new HTTPError(404, "Er is een probleem met uw aanvraag.");
        data[i] = d.data['HCP'];
    }

    let response = {
        data: null,
        error: null
    }
    if (error) {
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else
        response.data = data;
    return response;
}