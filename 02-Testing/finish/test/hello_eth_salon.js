var HelloEthSalon = artifacts.require("./HelloEthSalon.sol");

contract("HelloEthSalon:GetMessage", function (accounts) {
  it("should return one right after you register", async function() {
    let c = await HelloEthSalon.deployed();
    await c.userRegister();
    let count = await c.checkUsersCount.call();
    console.log("Count = " + count);
    assert.equal(count, 1);
  });

  it("should return right price after registered", async function () {
    const contract = await HelloEthSalon.deployed();

    let song = "hello world";
    let price = 0;
    await contract.registerCopyright(song, price);

    let result = await contract.checkSongPrice.call(song);
    console.log(result);
    assert.equal(price, result);
  });

  it("should return 0 for registered songs", async function () {
    const contract = await HelloEthSalon.deployed();

    let result = await contract.checkSongPrice.call("not registered fake song hehehe");
    console.log(result);
    assert.equal(result, 0);
  });


});
