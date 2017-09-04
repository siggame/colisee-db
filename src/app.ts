import * as fs from "fs";
import { promisify } from "util";

import { db, logger } from "@siggame/colisee-lib";

const writeFileAsync = promisify(fs.writeFile);

async function main() {
    const sql = await db.initializeDatabase(true);
    await writeFileAsync("init.sql", sql);
}

main().catch(e => logger.warn(e));
