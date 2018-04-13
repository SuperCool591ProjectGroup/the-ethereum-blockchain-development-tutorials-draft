var Copyright = artifacts.require("./Copyright.sol");

contract("Payment", function (accounts) {
	it("should work!!!!!!!!!", async function() {
		let seller = accounts[0];
		let buyer = accounts[1];

		let c = await Copyright.deployed();
		await c.userRegister({from: seller});
		await c.userRegister({from: buyer});
		console.log("both of them should be able to registered")

		let addrs = await c.checkUsers.call();
		console.log(addrs);		

		let song = "Awesome track!"
		await c.registerCopyright(song, 1000, {from: seller});
		console.log("upload a song")

		await c.buyLicense(song, {from: buyer, gas: 9999999999});
	});
});
