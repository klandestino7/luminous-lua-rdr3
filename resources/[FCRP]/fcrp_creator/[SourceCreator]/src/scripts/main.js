import Inventory from "./views/inventory";
import CreateChar from "./views/create-char";

class Main {
	constructor() {
		new Inventory();
		new CreateChar();
	}
}

window.onload = function() {
  new Main();
};
