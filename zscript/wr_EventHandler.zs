/* Copyright Alexander 'm8f' Kromm (mmaulwurff@gmail.com) 2020
 *
 * This file is a part of Warm Reception.
 *
 * Warm Reception is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) any
 * later version.
 *
 * Warm Reception is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Warm Reception.  If not, see <https://www.gnu.org/licenses/>.
 */

class wr_EventHandler : EventHandler
{

  override
  void WorldThingSpawned(WorldEvent event)
  {
    let monster = event.thing;
    let player  = players[consolePlayer].mo;
    if (monster == NULL || !monster.bIsMonster || player == NULL) return;

    switch (wr_mode)
    {
    case AllAwake:  alert(monster, player); return;
    case AllAsleep: turnAwayWhoLooksAtPlayer(monster, player); return;
    case AllAwakeEvenAmbush: alertAmbush(monster, player); return;
    case HotStart:  turnToLookAtPlayer(monster, player); return;
    }
  }

// private: ////////////////////////////////////////////////////////////////////////////////////////

  enum Mode
  {
    AllAwake,
    Vanilla,
    AllAsleep,
    AllAwakeEvenAmbush,
    HotStart,
  }

  private
  void alert(Actor monster, Actor player)
  {
    monster.SoundAlert(player);
  }

  private
  void alertAmbush(Actor monster, Actor player)
  {
    monster.bAmbush = false;
    monster.SoundAlert(player);
  }

  private
  void turnAwayWhoLooksAtPlayer(Actor monster, Actor player)
  {
    if (monster.CheckSight(player))
    {
      double awayAngle = monster.AngleTo(player) + 180.0;
      monster.A_SetAngle(awayAngle);
    }
  }

  private
  void turnToLookAtPlayer(Actor monster, Actor player)
  {
    if (monster.CheckSight(player))
    {
      monster.A_SetAngle(monster.AngleTo(player));
    }
  }

} // class wr_EventHandler
