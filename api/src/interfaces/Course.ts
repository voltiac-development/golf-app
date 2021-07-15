export interface Course {
    name: string,
    par: number,
    id: string,
    holes: number,
    image: string,
    roundTypes: RoundTypes[],
    teeBoxes: TeeBoxes,
}

export interface RoundTypes {
    roundTypeId: string,
    courseId: string,
    roundVariaton: string,
    startHole: number,
    endHole: number,
}

enum TeeBoxes {
    WHITE,
    BLUE,
    YELLOW,
    RED,
    ORANGE
}