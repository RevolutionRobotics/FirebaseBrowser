import React from 'react';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/core/styles';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Tabs from '@material-ui/core/Tabs';
import Tab from '@material-ui/core/Tab';
import Typography from '@material-ui/core/Typography';
import RobotList from './RobotList/RobotList.js'

function TabContainer(props) {
  return (
    <Typography component="div" style={{ padding: 8 * 3 }}>
      {props.children}
    </Typography>
  );
}

TabContainer.propTypes = {
  children: PropTypes.node.isRequired,
};

const useStyles = makeStyles(theme => ({
  root: {
    flexGrow: 1,
    backgroundColor: theme.palette.background.paper,
  },
}));

function SimpleTabs() {
  const classes = useStyles();
  const [value, setValue] = React.useState(0);

  function handleChange(event, newValue) {
    setValue(newValue);
  }

  return (
    <div className={classes.root}>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" className={classes.title}>
            Firebase browser
          </Typography>
        </Toolbar>
        <Tabs value={value} onChange={handleChange}>
          <Tab label="Robots" />
          <Tab label="Challanges" />
          <Tab label="Programs" />
        </Tabs>
      </AppBar>
      {value === 0 && <TabContainer><RobotList /></TabContainer>}
      {value === 1 && <TabContainer>Challanges</TabContainer>}
      {value === 2 && <TabContainer>Programs</TabContainer>}
    </div>
  );
}

export default SimpleTabs;