const express = require('express');
const axios = require('axios');

const app = express();
const port = process.env.PORT || 3000;
const teamsWebhookUrl = process.env.TEAMS_WEBHOOK_URL;

app.use(express.json());

app.get('/', (req, res) => {
  res.send('Jira-Teams integration bot running');
});

app.post('/jira-webhook', async (req, res) => {
  const { issue } = req.body;
  if (!teamsWebhookUrl) {
    console.error('TEAMS_WEBHOOK_URL not defined');
    return res.status(500).send('Teams webhook not configured');
  }
  if (issue && issue.fields) {
    const message = {
      text: `Issue ${issue.key} updated: ${issue.fields.summary}`,
    };
    try {
      await axios.post(teamsWebhookUrl, message);
      res.status(200).send('Message sent to Teams');
    } catch (err) {
      console.error('Error sending message to Teams:', err.message);
      res.status(500).send('Error sending to Teams');
    }
  } else {
    res.status(400).send('Invalid payload');
  }
});

app.listen(port, () => {
  console.log(`Bot listening on port ${port}`);
});
