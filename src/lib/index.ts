export const generateRefId = () => {
  const specialChars = '!@#$%^&*()_+[]{}|;:,.<>?';
  let referenceId = '';
  for (let i = 0; i < 6; i++) {
    const randomIndex = Math.floor(Math.random() * specialChars.length);
    referenceId += specialChars[randomIndex];
  }
  return referenceId;
};
