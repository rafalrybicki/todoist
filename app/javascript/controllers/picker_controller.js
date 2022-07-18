import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  calendarMonth = document.getElementById('calendar-month');
  calendarTitle = document.getElementById('calendar-title');
  prevMonthBtn = document.getElementById('prev-month');
  resteMonthBtn = document.getElementById('reset-month');
  nextMonthBtn = document.getElementById('next-month');

  initialize() {
    this.index = 0;
    this.calendar = getCalendar();
    this.calendarTitle.replaceChildren(this.calendar[0].title);
    this.calendarMonth.replaceChildren(...this.calendar[0].month);
  }

  togglePickerBody(e) {
    document.getElementById(e.target.dataset.target).classList.toggle('show');
  }

  changeMonth(e) {
    const value = e.target.dataset.value || e.target.parentElement.dataset.value;

    switch (value) {
      case 'prev':
        this.index > 0 ? this.index -= 1 : null;
        break;
      case 'next':
        this.index < 11 ? this.index += 1 : null;
        break;
      default:
        this.index = 0;
    }

    switch (this.index) {
      case 0:
        this.prevMonthBtn.setAttribute('disabled', true);
        this.resteMonthBtn.setAttribute('disabled', true);
        this.nextMonthBtn.removeAttribute('disabled');
        break;
      case 1:
        this.prevMonthBtn.removeAttribute('disabled');
        this.resteMonthBtn.removeAttribute('disabled');
        break;
      case 10:
        this.nextMonthBtn.removeAttribute('disabled');
        break;
      case 11:
        this.nextMonthBtn.setAttribute('disabled', true);
        break;
    }

    this.calendarMonth.replaceChildren(...this.calendar[this.index].month);
    this.calendarTitle.replaceChildren(...this.calendar[this.index].title);
  }

  selectDate(e) {
    console.log(e.target.dataset)
  }
}

function getCalendar() {
  const calendar = [];
  let year = new Date().getFullYear();
  let month = new Date().getMonth();

  for (let i = 0; i < 12; i++) {
    const startDay = getStartDate(year, month);
    const endDay = getEndDate(year, month);
    const firstDayOfTheMonth = getFirstDayOfTheMonth(year, month);
    const lastDayOfTheMonth = getLastDayOfTheMonth(year, month);
    const calendarItem = {
      title: `${months[month]} ${year}`,
      month: []
    };

    let day = startDay;

    while (day.valueOf() <= endDay.valueOf()) {
      const button = document.createElement('button');
      button.innerText = day.getDate();
      button.dataset.year = day.getFullYear();
      button.dataset.month = day.getMonth() + 1;
      button.dataset.day = day.getDate();
      button.setAttribute('type', 'button');

      if (day < firstDayOfTheMonth || day > lastDayOfTheMonth) {
        button.setAttribute('disabled', true);
      }

      calendarItem.month.push(button);
      day = new Date(day.valueOf() + 86400000);
    }

    if (month === 11) {
      month = 0;
      year += 1;
    } else {
      month += 1;
    }

    calendar.push(calendarItem);
  }

  return calendar
}

function getStartDate(year, month) {
  const firstDayOfTheMonth = getFirstDayOfTheMonth(year, month);
  const milisecondsToSubtract = (getDayOfTheWeek(firstDayOfTheMonth) - 1) * 86400000;
  const startDateMiliseconds = firstDayOfTheMonth.valueOf() - milisecondsToSubtract;

  return new Date(startDateMiliseconds);
}

function getEndDate(year, month) {
  const lastDayOfTheMonth = getLastDayOfTheMonth(year, month);
  const milisecondsToAdd = (7 - getDayOfTheWeek(lastDayOfTheMonth)) * 86400000;
  const endDateMiliseconds = lastDayOfTheMonth.valueOf() + milisecondsToAdd;

  return new Date(endDateMiliseconds);
}

function getFirstDayOfTheMonth(year, month) {
  return new Date(year, month, 1);
}

function getLastDayOfTheMonth(year, month) {
  return new Date(year, month + 1, 0);
}

function getDayOfTheWeek(date) {
  const day = date.getDay();

  return day === 0 ? 7 : day;
}

const months = ['January', 'Feabruary', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];