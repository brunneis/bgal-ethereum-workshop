pragma solidity 0.5.12;


contract CopyrightRegistry {

    struct License {
        string name;
        bool exists;
    }
    event AddLicense (
        bytes32 _hash,
        string _name,
        uint256 _timestamp
    );
    mapping(bytes32 => License) licenses;

    struct Record {
        string name;
        string description;
        bytes32 license;
        bool exists;
    }
    event AddRecord (
        bytes32 _hash,
        string _name,
        string _description,
        bytes32 _license,
        uint256 _timestamp
    );
    mapping(bytes32 => Record) registry;

    function addRecord(
        bytes32 _hash,
        string memory _name,
        string memory _description,
        bytes32 _license
    ) public {
        require(!registry[_hash].exists, "the record already exists");
        require(licenses[_license].exists, "the license does not exist");
        registry[_hash] = Record(_name, _description, _license, true);
        emit AddRecord(_hash, _name, _description, _license, block.timestamp);
    }

    function getRecord(
        bytes32 _hash
    ) public view returns (
        string memory _name,
        string memory _description,
        bytes32 _license
    ) {
        require(registry[_hash].exists, "the record does not exist");
        _name = registry[_hash].name;
        _description = registry[_hash].description;
        _license = registry[_hash].license;
    }

    function addLicense(
        bytes32 _hash,
        string memory _name
    ) public {
        require(!licenses[_hash].exists, "the license already exists");
        licenses[_hash] = License(_name, true);
        emit AddLicense(_hash, _name, block.timestamp);
    }

    function getLicense(
        bytes32 _hash
    ) public view returns (
        string memory _name
    ) {
        require(licenses[_hash].exists, "the license does not exist");
        _name = licenses[_hash].name;
    }

}
