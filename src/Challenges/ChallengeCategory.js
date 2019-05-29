import React from 'react';
import Grid from '@material-ui/core/Grid';
import Card from '@material-ui/core/Card';
import CardActionArea from '@material-ui/core/CardActionArea';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import "./ChallengeCategory.css";

const ChallengeCategory = ({ category }) => (
    <Grid key={category.id} item>
        <Card className="card">
            <CardActionArea>
                <CardMedia
                    className="media"
                    image={category.image}
                    title="Contemplative Reptile"
                />
                <CardContent>
                    <Typography gutterBottom variant="h5" component="h2">
                        {category.name}
                    </Typography>
                    <Typography variant="body2" color="textSecondary" component="p">
                        {category.description}
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

export default ChallengeCategory;