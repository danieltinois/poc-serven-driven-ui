import homeScreen from "../examples/screen.home.json" assert { type: "json" };
import { validateDynamicScreen } from "./index";

validateDynamicScreen(homeScreen);
console.log("screen.home.json valido");
