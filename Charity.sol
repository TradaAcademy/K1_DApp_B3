pragma solidity 0.4.24;

interface userKyc {
    function isUserKyced(address _userAddress) constant public returns(bool);
}

contract CharityContract {
    // Read/write candidate
    address public admin;

    userKyc public kycList;    

    mapping (address => uint256) public charityPoints;    

    //constant, not store in ethereum state
    uint256 maxValueDonate = 100000000000000000;
    

    event DonateETH(address indexed _userAddr, uint256 value);

    event Claim(uint256 value);
    // event AddUser(address indexed _userAddr, string _userName, string _userEmail);
    // event RemoveUser(address indexed _userAddr);

    // Constructor
    constructor () public {
        admin = msg.sender;
    }
    
    function setKycAddress(userKyc _kycList){
        require(msg.sender == admin);
        kycList = _kycList;
    }
    
    function donate() public{
        require(kycList.isUserKyced(msg.sender));
        require(msg.value + charityPoints[msg.sender] <= maxValueDonate);

        charityPoints[msg.sender] += msg.value;
        emit DonateETH(msg.sender, msg.value);
    }   

    function  claim() public payable{
        require(
            msg.sender == address(admin),
            "Only admin can call this."
        );
        uint256 balance = address(this).balance;
        msg.sender.transfer(balance);
        emit Claim(balance);
    }

    function  transferAdmin(address _adminAddr) public {
        require(
            msg.sender == address(admin),
            "Only admin can call this."
        );
        admin = _adminAddr;
    }

}