const truncateText = (maxCharacters) => {
  document.querySelectorAll('.truncate-text').forEach((element) => {
    const text = element.textContent;
    if (text.length > maxCharacters) {
      element.textContent = text.slice(0, maxCharacters) + '...';
    }
  });
};

export { truncateText };