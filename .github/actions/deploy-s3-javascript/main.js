import { notice, getInput, setOutput } from '@actions/core';
import * as gh_actions from '@actions/github';
import { exec } from '@actions/exec';

run();

function run() {
  const bucket = getInput('bucket');
  const region = getInput('region');
  const distFolder = getInput('dist-folder');

  notice('Hello from github action');
  exec('ls');
  exec('pwd');
  exec(`aws s3 sync ${distFolder} s3://${bucket} --region ${region}`);

  const s3URL = `https://${bucket}.s3-website-${region}.amazonaws.com`;
  setOutput('s3-url', s3URL);
}
