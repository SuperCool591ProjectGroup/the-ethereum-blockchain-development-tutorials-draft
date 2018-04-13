pragma solidity ^0.4.4;

contract HelloEthSalon {
  string message = "I know smart contract testing!!";
  string[] public songs;
  address[] public users;
  // assume one song only has one copyright holder for now
  mapping(string => ShareHolder) holderInfo;
  mapping(string => uint) priceInfo;
  mapping(string => address[]) authorization;

  struct ShareHolder {
    address add;
    uint share;
  }

  // function userRegister() returns (address[]){
  function userRegister() returns (string){
    users.push(msg.sender);
    return "user registered";
    // return users;
  }

  function registerCopyright(string song, uint price) public returns (string) {
    require(checkUserExists(msg.sender));
    songs.push(song);
    priceInfo[song] = price;
    holderInfo[song].add = msg.sender;
    holderInfo[song].share = 1;
    // authorization[song] = address[];
    // return holderInfo[song].add;
    return "copyright registered";
  }

  function checkUserExists(address user) public constant returns(bool) {
    for(uint i = 0; i < users.length; i++) {
      if(users[i] == user)
        return true;
    }
    return false;
  }
  
  function HelloEthSalon() {
    // constructor
  }

  function GetMessage() returns (string) {
    return message;
  }
}
