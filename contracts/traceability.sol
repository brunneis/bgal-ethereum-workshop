pragma solidity 0.5.2;


contract Traces {

    struct Event {
        bytes32 hash_;
        string type_;
        string description;
        bool exists;
    }
    event AddEvent (
        bytes32 _trace,
        bytes32 _hash,
        string _type,
        string _description,
        uint256 _index,
        uint256 _timestamp
    );

    struct Trace {
        Event[] events;
        uint256 nextIndex;
        bool exists;
    }
    event AddTrace (
        bytes32 _hash,
        uint256 _timestamp
    );
    mapping(bytes32 => Trace) traces;

    function addTrace (
        bytes32 _hash
    ) public {
        require(!traces[_hash].exists, "the trace already exists");
        traces[_hash].exists = true;
    }

    function existsTrace (
        bytes32 _hash    
    ) public view returns (bool) {
        if (traces[_hash].exists) {
            return true;
        }
        return false;
    }

    function addEvent (
        bytes32 _trace,
        bytes32 _hash,
        string memory _type,
        string memory _description
    ) public {
        require(traces[_trace].exists, "the traces does not exist");
        traces[_trace].events.push(Event(_hash, _type, _description, true));
        emit AddEvent(_trace, _hash, _type, _description, traces[_trace].nextIndex, block.timestamp);
        traces[_trace].nextIndex++;
    }

    function getTraceLenght (
        bytes32 _hash
    ) public view returns (
        uint256 length
    ) {
        require(traces[_hash].exists, "the trace does not exist");
        length = traces[_hash].nextIndex;
    }

    function getEventGivenIndex (
        bytes32 _trace,
        uint256 _index
    ) public view returns (
        string memory type_,
        string memory description
    ) {
        require(traces[_trace].exists, "the trace does not exist");
        require(traces[_trace].events[_index].exists, "the event does not exist");
        type_ = traces[_trace].events[_index].type_;
        description = traces[_trace].events[_index].description;
    }

}
