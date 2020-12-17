import { LitElement, html, css } from 'https://unpkg.com/lit-element@2.4.0/lit-element.js?module';

class LeaderBoard extends LitElement {
  static get properties() {
    return { members: { type: Object } };
  }

  static get styles() {
    return css`
    `;
  }

  static groupMembers(members) {
    let groups = {};
    members.forEach(member => {
      if (!groups[member.stars]) groups[member.stars] = [];
      groups[member.stars].push(member)
    });
    return groups;
  }

  static names(members) {
    return members.map(i => i.name)
      .sort((a,b) => Math.round(Math.random() * 2 - 1));
  }

  constructor() {
    super();
    this.members = [];
    this.fetchMembers();
  }
  
  fetchMembers() {
    fetch('/leaderboard')
      .then(res => res.json())
      .then(json => {
        let members = Object.values(json.members);
        this.members = LeaderBoard.groupMembers(members);
      })
  }

  sortedStars() {
    return Object.keys(this.members)
      .map(i => parseInt(i))
      .sort((a,b) => a < b ? -1 : 1)
      .reverse();
  }

  render() {
    return html`
      <ul>
      ${ this.sortedStars().map(stars => {
        let members = this.members[stars]
        return html`<li>
          <strong class="score">${stars}</strong>
          <ul>
            ${LeaderBoard.names(members).map(name => {
              return html`<li class='name'>${name}</li>`;
            })}
          </ul>
        </li>`;
      })}
      </ul>
    `
  }
}

customElements.define('leader-board', LeaderBoard);
