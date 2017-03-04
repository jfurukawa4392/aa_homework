import React from 'react';
import Clock from './clock';
import Tabs from './tabs';

const lorem = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
const tabs = [{title: "Tab 1", content: lorem },
{title: "Tab 2", content: lorem },
{title: "Tab 3", content: lorem }
];

class Root extends React.Component {
  render () {
    return (<div>
      <Tabs tabs={tabs} />
      <Clock/>
    </div>);
  }
}

export default Root;
