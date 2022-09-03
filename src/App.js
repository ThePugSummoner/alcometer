import logo from './logo.svg';
import './App.css';
import {useState} from 'react'

function App() {

  const [weight, setWeight] = useState(0)
  const [bottles, setBottles] = useState(0)
  const [time, setTime] = useState(0)
  const [gender, setGender] = useState(0)
  const [level, setLevel] = useState()

  function Calculate(e) {
    //e.preventDefault()
    const litres = bottles * 0.33
    const grams = litres * 8 * 4.5
    const burning = weight / 10
    const gramsleft = grams - (burning * time)
    const result = gramsleft / (weight * gender)

    if (result <= 0) {
      setLevel("Your alcohol level is "+ 0)
    }
    else if (gramsleft == 0) {
      setLevel("Your alcohol level is " + 0)
    }
    else {
      setLevel("Your alcohol level is " + result.toFixed(2))
    }
  }

  return (
    <form onSubmit={Calculate}>
      <h1>Alcometer</h1>
      <div>
        <label>Weight</label>
        <input type="number" className="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" value={weight} onChange={e => setWeight(e.target.value)}/>
      </div>
      <div>
      <label>Bottles</label>
      <input type="number" className="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" value={bottles} onChange={e => setBottles(e.target.value)}/>
      </div>
      <div>
      <label>Time</label>
      <input type="number" className="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" value={time} onChange={e => setTime(e.target.value)}/>
      </div>
      <div className="form-check form-check-inline">
      <input className="form-check-input" type="radio" name="inlineRadioOptions" value={gender} onClick={e => setGender(0.7)}/>
      <label className="form-check-label">Male</label>
      </div>
      <div className="form-check form-check-inline">
      <input className="form-check-input" type="radio" name="inlineRadioOptions"  value={gender} onClick={e => setGender(0.6)}/>
      <label className="form-check-label">Female</label>
      </div>
      <div>
      <button type='button' onClick={Calculate}>Calculate</button>
      </div>
      <div>
      <output>{level}</output>
      </div>
    </form>
  )
}

export default App;
