import React from 'react';
import Grid from '@material-ui/core/Grid';
import Card from '@material-ui/core/Card';
import CardActionArea from '@material-ui/core/CardActionArea';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import "./Robot.css";

const Robot = ({ robot }) => (
    <Grid key={robot.id} item>
        <Card className="card">
            <CardActionArea>
                <CardMedia
                    className="media"
                    image={robot.coverImage}
                    title="Contemplative Reptile"
                />
                <CardContent>
                    <Typography gutterBottom variant="h5" component="h2">
                        {robot.name}
                    </Typography>
                    <Typography variant="body2" color="textSecondary" component="p">
                        {robot.description}
                    </Typography>
                </CardContent>
            </CardActionArea>
            <CardActions>
                <Button size="small" color="primary">
                    Edit
        </Button>
                <Button size="small" color="primary">
                    Delete
        </Button>
            </CardActions>
        </Card>
    </Grid>
);

export default Robot;