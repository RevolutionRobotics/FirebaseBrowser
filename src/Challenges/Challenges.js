import React from 'react';
import ChallengeCategoryList from './ChallengeCategoryList.js'
import ChallengeCategoryDetails from './ChallengeCategoryDetails.js'
import { BrowserRouter as Router, Route, Link } from "react-router-dom";
import './Challenges.css'

class Challenges extends React.Component {

    render() {
        return (
            <Router>
                <Route exact path="/" render={() => (
                    <ChallengeCategoryList />
                )} />
                <Route path='/challenge/:id' component={ChallengeCategoryDetails} />
            </Router>
        )
    }

}

export default Challenges;