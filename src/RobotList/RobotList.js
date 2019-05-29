import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/styles';
import Grid from '@material-ui/core/Grid';
import firebase from '../firebase.js';
import Robot from './Robot.js'
import './RobotList.css'

class RobotList extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            robots: []
        }
    }

    componentDidMount() {
        const wordRef = firebase.database().ref('robot');
        const storage = firebase.storage();
        wordRef.on('value', (snapshot) => {
            let robots = snapshot.val();
            let newState = [];
            for (let robot in robots) {
                var newRobot = {
                    id: robot,
                    name: robots[robot].name,
                    description: robots[robot].description,
                    coverImage: robots[robot].coverImage
                }
                newState.push(newRobot);
                this.getImage(storage, newRobot);

            }
            this.setState({
                robots: newState
            });
        });
    };

    render() {
        return (
            <Grid container className="root" justify="center" spacing='2'>
                {this.state.robots.map((robot) => (
                    <Robot key={robot.id} robot={robot} />
                ))
                }
            </Grid>
        )
    }

    getImage(storage, robot) {
        storage.refFromURL(robot.coverImage).getDownloadURL().then((url) => {
            this.state.robots.find(r => r.id === robot.id).coverImage = url;
            //this.state.robots[robot.id] = url
            this.setState(this.state)
        }).catch((error) => {
            console.error(error);
        })
    }

}

export default RobotList;