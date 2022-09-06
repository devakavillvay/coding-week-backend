// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";

contract VillvayCerts is Ownable, EIP712 {
    struct Certificate {
        address studentAddress;
        string name;
        string qualification;
        string major;
        string ipfsHash;
    }

    constructor() EIP712("The University of Villvay", "1.0") {}

    mapping(address => Certificate) private studentCerts;

    function grantCertificate(address student, Certificate calldata details) public onlyOwner{
        require(_msgSender() == owner(), "You are not the University!!! >:(");
        studentCerts[student] = details;
        return;
    }

    function getCertificateByStudent(address student) public view returns (Certificate memory){
        return studentCerts[student];
    }    
}