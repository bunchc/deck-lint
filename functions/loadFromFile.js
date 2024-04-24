const fs = require('fs');

module.exports = (targetVal, opts) => {
  const values = fs.readFileSync(opts.filename, 'utf8').split('\n').filter(Boolean);
  if (values.includes(targetVal)) {
    return [
      {
        message: `Value ${targetVal} is not allowed.`,
      },
    ];
  }
};
