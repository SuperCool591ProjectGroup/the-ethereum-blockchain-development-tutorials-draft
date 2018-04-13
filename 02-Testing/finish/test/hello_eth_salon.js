var HelloEthSalon = artifacts.require("./HelloEthSalon.sol");

contract("HelloEthSalon:GetMessage", function (accounts) {
  it("should return a correct string", async function () {
    const contract = await HelloEthSalon.deployed();
    const result = await contract.GetMessage.call();
    assert.isTrue(result === "I know smart contract testing!!");
  });

  it("should return registered", async function () {
    const contract = await HelloEthSalon.deployed();
    const result = await contract.userRegister.call();
    // console.log(result);
    assert.isTrue(result === "user registered");
  });

  it("should return Copyright registered", async function () {
    const contract = await HelloEthSalon.deployed();
    const result = await contract.registerCopyright.call("hello world", 1000);
    console.log(result);
    assert.isTrue(result === "True");
  });

});
