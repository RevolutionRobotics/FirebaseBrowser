import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/styles';
import Grid from '@material-ui/core/Grid';
import firebase from '../firebase.js';
import ChallengeCategory from './ChallengeCategory.js'
import './Challenges.css'

class Challenges extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            challengeCategories: []
        }
    }

    componentDidMount() {
        const wordRef = firebase.database().ref('challengeCategory');
        const storage = firebase.storage();
        wordRef.on('value', (snapshot) => {
            let challengeCategories = snapshot.val();
            let newState = [];
            for (let categoryId in challengeCategories) {
                var chellange = {
                    id: categoryId,
                    name: challengeCategories[categoryId].name,
                    description: challengeCategories[categoryId].description,
                    image: challengeCategories[categoryId].image
                }
                newState.push(chellange);
                this.getImage(storage, chellange);

            }
            this.setState({
                challengeCategories: newState
            });
        });
    };

    render() {
        return (
            <Grid container className="root" justify="center" spacing='2'>
                {this.state.challengeCategories.map((category) => (
                    <ChallengeCategory key={category.id} category={category} />
                ))
                }
            </Grid>
        )
    }

    getImage(storage, challenge) {
        storage.refFromURL(challenge.image).getDownloadURL().then((url) => {
            this.state.challengeCategories.find(r => r.id === challenge.id).image = url;
            this.setState(this.state)
        }).catch((error) => {
            console.error(error);
        })
    }

}

export default Challenges;