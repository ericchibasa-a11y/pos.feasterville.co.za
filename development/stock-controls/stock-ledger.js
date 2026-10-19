/* Offline stock ledger, no network or database writes. */
'use strict';
function quantity(v,label){if(typeof v!=='number'||!Number.isFinite(v)||v<0)throw Error(label+' invalid');return v;}
function instant(s){if(typeof s!=='string'||!/([zZ]|[+-]\d\d:\d\d)$/.test(s)||!Number.isFinite(Date.parse(s)))throw Error('Offset-aware timestamp required');return Date.parse(s);}
function calculateAfterCount({countQty,countedAt,movements=[]}){
 let balance=quantity(countQty,'countQty'), baseline=instant(countedAt), seen=new Set(), applied=0;
 const sign={receipt:1,transfer_in:1,sale:-1,transfer_out:-1,waste:-1,adjustment_in:1,adjustment_out:-1,sale_reversal:1};
 for(const m of movements){
  if(!m||typeof m.ref!=='string'||!m.ref.trim())throw Error('Movement reference required');
  if(seen.has(m.ref))throw Error('Duplicate movement '+m.ref); seen.add(m.ref);
  let when=instant(m.at), q=quantity(m.qty,'qty');
  if(!Object.prototype.hasOwnProperty.call(sign,m.type))throw Error('Unknown movement type');
  if(m.type.startsWith('adjustment_')&&(!m.approver||!m.reason))throw Error('Manager approval and reason required');
  if(when>baseline){balance+=sign[m.type]*q;applied++;}
 }
 return {balance:Math.round(balance*1e6)/1e6,negative:balance<0,appliedMovements:applied,countQty,countedAt};
}
if(typeof module!=='undefined')module.exports={calculateAfterCount};