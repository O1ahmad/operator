/** @format */

import Dropdown from "./Dropdown";
import "./styles.css";

export default function App() {
  const options = [
    { value: "avalanchego", label: "Avalanche" },
    { value: "bitcoind", label: "Bitcoin" },
    { value: "bitcoin-abc", label: "Bitcoin Cash" },
    { value: "geth", label: "Geth" },
    { value: "prysm", label: "Prysm" },
    { value: "mev-boost", label: "MEV Boost" }
  ];

  return (
    <div className="App">
      <Dropdown
        isSearchable
        isMulti
        placeHolder="Select..."
        options={options}
        onChange={(value) => console.log(value)}
      />
    </div>
  );
}
