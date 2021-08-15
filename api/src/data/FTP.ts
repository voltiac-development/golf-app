import ftp from 'basic-ftp'
import fs from 'fs';

export async function example(file) {
    const client = new ftp.Client()
    client.ftp.verbose = true
    try {
        await client.access({
            host: "ftp.bartverm.dev",
            user: "golfcaddie_api",
            password: "Bartbart!9",
            secure: true
        })
        // console.log(await client.list('./golfcaddie/profile/'))
        await client.cd('./golfcaddie/profile/')
        console.log('fff')
        console.log(file);
        // await client.uploadFrom(file['path'], "test.jpg")
        await client.uploadFrom(file['path'], 'test.png')
        // await client.downloadTo("avatar.png", "./golfcaddie/profile/avatar.png")
    }
    catch(err) {
        console.log(err)
    }
    client.close()
    return null;
}
