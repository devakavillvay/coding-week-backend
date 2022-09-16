import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config";

const config: HardhatUserConfig = {
    solidity: "0.8.16",
    networks: {
        rinkeby: {
            url: process.env.RINKEBY_URL,
            accounts: [process.env.RINKEBY_SK as string],
        },
    },
};

export default config;
