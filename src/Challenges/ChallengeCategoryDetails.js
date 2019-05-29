import React from 'react';
import Grid from '@material-ui/core/Grid';
import Card from '@material-ui/core/Card';
import CardActionArea from '@material-ui/core/CardActionArea';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import { BrowserRouter as Router, Route, Link } from "react-router-dom";
import firebase from '../firebase.js';
import "./ChallengeCategory.css";

class ChallengeCategoryDetails extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            categoryId: props.match.params.id
        }
    }

    componentDidMount() {
        const wordRef = firebase.database().ref('challengeCategory/' + this.state.categoryId);
        wordRef.on('value', (snapshot) => {
            this.state.category = snapshot.val();
            this.setState(this.state);
        });
    };

    render() {
        return (
            <div>
                <h3>Category details</h3>
                <p>{this.state.categoryId}</p>
                <p>{!!(this.state.category) ? this.state.category.name : "Loading..."}</p>
            </div>
        )
    }
}

export default ChallengeCategoryDetails;