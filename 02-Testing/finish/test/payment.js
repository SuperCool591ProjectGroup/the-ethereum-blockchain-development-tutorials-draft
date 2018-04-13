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

		let prevBuyerBalance = await c.getMyBalance.call({from: buyer});
		console.log("Buyer's previous balance: " + prevBuyerBalance);
		let prevBalance = await c.getMyBalance.call({from: seller});
		console.log("Seller's previous balance: " + prevBalance);

		await c.buyLicense(song, {from: buyer, value: 1001});

		let newBuyerBalance = await c.getMyBalance.call({from: buyer});
		console.log("Buyer's new balance?: " + newBuyerBalance);
		let newBalance = await c.getMyBalance.call({from: seller});
		console.log("Seller's new balance?: " + newBalance);
		

		let difference = newBalance.toNumber() - prevBalance.toNumber();
		console.log("Difference: " + difference);

		assert.isTrue(true);
	});
});
