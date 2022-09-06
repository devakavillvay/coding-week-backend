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

    function verifyCert(Certificate calldata cert, bytes calldata signature) public view returns (bool) {
        address signer = _validateSignature(_hash(cert), signature);
        if(signer == owner()){
            return true;
        }
        return false;
    }

    function _hash(
      Certificate calldata cert
    ) internal view returns (bytes32) {
        bytes32 digest = _hashTypedDataV4(
            keccak256(
                abi.encode(
                    keccak256("Certificate(address studentAddress,string name,string qualification,string major,string ipfsHash)"),
                    cert.studentAddress, keccak256(bytes(cert.name)), keccak256(bytes(cert.qualification)), keccak256(bytes(cert.major)), keccak256(bytes(cert.ipfsHash))
        )));
        return digest;
    }
    
    function _validateSignature(bytes32 digest, bytes memory signature) internal pure returns (address) {
        address signer = ECDSA.recover(digest, signature);
        return signer;
    }
}