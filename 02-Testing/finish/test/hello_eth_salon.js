var HelloEthSalon = artifacts.require("./HelloEthSalon.sol");

contract("HelloEthSalon:GetMessage", function (accounts) {
  // it("should return registered", async function () {
  //   const contract = await HelloEthSalon.deployed();
  //   const result = await contract.userRegister.call();
  //   // console.log(result);
  //   assert.isTrue(result === "user registered");
  // });

  it("should return one right after you register", async function() {
    var contract = HelloEthSalon.deployed()
    contract.then(function(instance) {
      c = instance
      return c.userRegister.call();;
    }).then(function(r) {
      console.log("user counts after register: " + r);
      return c.checkUsersCount.call();
    }).then(function(r) {
      console.log("the result: " + r);
      assert.equal(r.toNumber(), 1);
    });

    // const myAddr = await contract.userRegister.call();
    // console.log("this is my address: " + myAddr);
    // // const result = await contract.checkUserExists.call(myAddr);
    // const result = await contract.checkUsersCount.call();
    // console.log("the result: " + result);
    // assert.isTrue(result == 1);
  });

  // it("should return true right after you register", async function() {
  //   const contract = await HelloEthSalon.deployed();
  //   const myAddr = await contract.userRegister.call();
  //   console.log("this is my address: " + myAddr);
  //   // const result = await contract.checkUserExists.call(myAddr);
  //   const result = await contract.printAllUsers.call();
  //   console.log("the result: " + result);
  //   assert.isTrue(result);
  // });

  // it("should return Copyright registered", async function () {
  //   const contract = await HelloEthSalon.deployed();
    
  //   console.log("register this tester process??");
  //   const testSetupResult = await contract.userRegister.call();
  //   console.log(testSetupResult);

  //   const result = await contract.registerCopyright.call("hello world", 1000);
  //   console.log(result);
  //   assert.isTrue(result === "copyright registered");
  // });

});
