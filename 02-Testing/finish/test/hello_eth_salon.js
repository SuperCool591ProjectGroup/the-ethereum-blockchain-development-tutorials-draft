var HelloEthSalon = artifacts.require("./HelloEthSalon.sol");

contract("HelloEthSalon:GetMessage", function (accounts) {
  // it("should return registered", async function () {
  //   const contract = await HelloEthSalon.deployed();
  //   const result = await contract.userRegister.call();
  //   // console.log(result);
  //   assert.isTrue(result === "user registered");
  // });

  it("should return one right after you register", async function() {
    let c = await HelloEthSalon.deployed();
    let t = await c.userRegister.sendTransaction();
    let count = await c.checkUsersCount.call();
    console.log("Count = " + count);
    assert.equal(count == 1);

    // const myAddr = await contract.userRegister.call();
    // console.log("this is my address: " + myAddr);
    // // const result = await contract.checkUserExists.call(myAddr);
    // const result = await contract.checkUsersCount.call();
    // console.log("the result: " + result);
    // assert.isTrue(result == 1);
  });


  it("should return Copyright registered", async function () {
    const contract = await HelloEthSalon.deployed();

    console.log("register this tester process??");
    const testSetupResult = await contract.userRegister.call();
    console.log(testSetupResult);

    const result = await contract.registerCopyright.call("hello world", 1000);
    console.log(result);
    assert.isTrue(result === "copyright registered");
  });

});
